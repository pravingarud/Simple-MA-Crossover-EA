# Simple MA Crossover EA (MT5)

A basic Expert Advisor (EA) for MetaTrader 5 that uses a simple Moving Average crossover strategy to enter buy and sell trades.

## 📌 Strategy Logic

- **Buy**: When the Fast MA crosses above the Slow MA
- **Sell**: When the Fast MA crosses below the Slow MA
- **Exit**: Fixed Stop Loss and Take Profit
- **One trade at a time** to avoid conflict

## ⚙️ Inputs

| Parameter     | Description                    |
|---------------|--------------------------------|
| `FastMAPeriod` | Period of the fast EMA         |
| `SlowMAPeriod` | Period of the slow EMA         |
| `LotSize`      | Volume per trade               |
| `StopLoss`     | Stop loss in points            |
| `TakeProfit`   | Take profit in points          |

## 🛠 How to Use

1. Open MetaEditor (MT5)
2. Paste the code into a new EA file named `SimpleMACrossover.mq5`
3. Compile and attach the EA to any chart
4. Run strategy tester to backtest

## 📈 Screenshot / Backtest Report

_Add a screenshot here if you have one from MT5 Strategy Tester_

## 📂 File

- `SimpleMACrossover.mq5` — Full EA source code

---

### 📬 Contact

If you’re looking for custom EA development or Pine Script strategies, feel free to reach out!

---

🔗 Made with ❤️ by Prawy
