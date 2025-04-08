//+------------------------------------------------------------------+
//|                                             SimpleMACrossover.mq5 |
//|                                    © 2025 Prawy Trading Projects |
//+------------------------------------------------------------------+
#property strict

input int FastMAPeriod = 12;
input int SlowMAPeriod = 26;
input double LotSize = 0.1;
input double StopLoss = 100;
input double TakeProfit = 200;

int fast_ma_handle;
int slow_ma_handle;
double fast_ma[], slow_ma[];

int OnInit()
{
   fast_ma_handle = iMA(_Symbol, _Period, FastMAPeriod, 0, MODE_EMA, PRICE_CLOSE);
   slow_ma_handle = iMA(_Symbol, _Period, SlowMAPeriod, 0, MODE_EMA, PRICE_CLOSE);

   if (fast_ma_handle == INVALID_HANDLE || slow_ma_handle == INVALID_HANDLE)
   {
      Print("Failed to get MA handles.");
      return INIT_FAILED;
   }
   return INIT_SUCCEEDED;
}

void OnDeinit(const int reason)
{
   IndicatorRelease(fast_ma_handle);
   IndicatorRelease(slow_ma_handle);
}

void OnTick()
{
   if (!CopyBuffer(fast_ma_handle, 0, 0, 3, fast_ma) ||
       !CopyBuffer(slow_ma_handle, 0, 0, 3, slow_ma))
   {
      Print("Failed to copy buffer.");
      return;
   }

   // Check for crossover
   if (fast_ma[1] < slow_ma[1] && fast_ma[0] > slow_ma[0])
   {
      // Buy Signal
      if (PositionSelect(_Symbol)) return;
      trade(ORDER_TYPE_BUY);
   }
   else if (fast_ma[1] > slow_ma[1] && fast_ma[0] < slow_ma[0])
   {
      // Sell Signal
      if (PositionSelect(_Symbol)) return;
      trade(ORDER_TYPE_SELL);
   }
}

void trade(const ENUM_ORDER_TYPE type)
{
   double sl = 0, tp = 0;
   double price = (type == ORDER_TYPE_BUY) ? SymbolInfoDouble(_Symbol, SYMBOL_ASK)
                                            : SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double point = _Point;

   if (type == ORDER_TYPE_BUY)
   {
      sl = price - StopLoss * point;
      tp = price + TakeProfit * point;
   }
   else
   {
      sl = price + StopLoss * point;
      tp = price - TakeProfit * point;
   }

   MqlTradeRequest request;
   MqlTradeResult result;

   ZeroMemory(request);
   ZeroMemory(result);

   request.action = TRADE_ACTION_DEAL;
   request.symbol = _Symbol;
   request.volume = LotSize;
   request.type = type;
   request.price = price;
   request.sl = sl;
   request.tp = tp;
   request.deviation = 10;
   request.magic = 123456;
   request.type_filling = ORDER_FILLING_FOK;
   request.type_time = ORDER_TIME_GTC;

   if (!OrderSend(request, result))
   {
      Print("Trade failed: ", result.retcode);
   }
}
