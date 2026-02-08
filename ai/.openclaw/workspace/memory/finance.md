# Finance Memory

# Instruction

Monitor the stock market and deliver two daily reports: 9:00 AM ET (pre-market outlook) and 5:00 PM ET (market close summary and outlook tomorrow).

Detail:

- Complete investigation within 10-15 minutes, deliver report in 5-10 minutes
- Focus only on stocks in (## Stock Watchlist) - ignore everything else
- Scan and summarize the transcription new youtube videos you haven't watched from the previous report or previous day from the (## Youtuber to watch), you will need it when you write the report
- Actively scan for market-moving events including: Federal Reserve announcements, geopolitical conflicts/wars, major policy changes, China trade deals, cryptocurrency crashes (especially Bitcoin), significant market sentiment shifts, and any other catalysts that could impact my positions. Check CNBC and major financial news sources regularly for breaking developments.
- Alert Criteria: Only notify me of important, actionable updates. If the market is trading normally with no significant catalysts, remain silent - do not send routine updates. Alert me immediately when: (1) major news breaks that could move the market, (2) any stock in my watchlist has unusual volume or price movement >5%, (3) Fed officials make statements, (4) geopolitical events escalate, or (5) sector-specific news impacts my holdings.
- Daily Close Summary: At 5:00 PM ET when markets close, provide a concise end-of-day report containing: (1) performance summary of all watchlist tickers with percentage changes, (2) top 3 gainers and losers from my list with brief explanations, and (3) a single paragraph summarizing the day's market narrative - what drove the action, any catalysts, and sentiment heading into the next session.
- Tone: Be concise, actionable, and skip the fluff. I want signal, not noise.
- Check the VIX (CBOE Volatility Index) at market close. Report the current VIX level and compare it against: (1) the peak VIX from the past 1 week, and (2) the peak VIX from the past 1 month. Flag any anomalies - specifically if VIX spikes >20% above recent averages, drops to unusually low levels (<12), or shows rapid changes that suggest fear/complacency extremes. Include this in the daily summary with context on what the volatility reading means for market conditions.
- Calculate the 2-period RSI (RSI-2) for TQQQ at market close. Report the exact RSI-2 value and signal status:
Oversold: RSI-2 < 10 (potential buy signal - mean reversion opportunity)
Neutral: RSI-2 between 10-90
Overbought: RSI-2 > 90 (potential sell signal - pullback likely)
- You can remove optional sections in the report if there is nothing happen, those are: [⚠️ BREAKING], [Earning Report Today], [Earning Report Tomorrow], [Youtuber picks]
- You don't have to explain everything if market only move by 1% and there's no news at all, don't waste time & token.

## Example Report 9AM

Market Alert - 9:00AM - 1 Jan 2026

⚠️ BREAKING:

- Fed Chair Powell just signaled potential pause in rate cuts during Q&A at economic forum. 10-year Treasury yields spiking +12 bps to 4.28%.
Impacted stocks: NVDA, TSLA, META, GOOG
source: [https://www.cnbc.com/2026/01/01/investing/treasury-yields/index.html](https://www.cnn.com/2023/08/29/investing/treasury-yields/index.html)

- Earning Report Today (for 9AM):
  Before Market: AMD (likely beat), NVDA (will not beat and will crash),
  During Market: TSLA (neutral),
  After Market: GOOG (will beat, likely to the moon)

- VIX: 18.42 (1W peak: 16.85, +9.3% | 1M peak: 21.30, -13.5%) - Moderate fear, slightly elevated
- TQQQ RSI-2: 8.3 🟢 OVERSOLD - extreme short-term oversold, mean-reversion bounce likely 1-3 days

## Example Report 5PM

Market Summary - 5:00PM - 1 Jan 2026

⚠️ BREAKING:

- Fed Chair Powell just signaled potential pause in rate cuts during Q&A at economic forum. 10-year Treasury yields spiking +12 bps to 4.28%.
Impacted stocks: NVDA, TSLA, META, GOOG
source: [https://www.cnbc.com/2026/01/01/investing/treasury-yields/index.html](https://www.cnn.com/2023/08/29/investing/treasury-yields/index.html)

- Earning Report Tomorrow (for 5PM):
  Before Market: AMD (likely beat), NVDA (will not beat and will crash),
  During Market: TSLA (neutral),
  After Market: GOOG (will beat, likely to the moon)

🎥 YouTube Picks (Last 24hrs):

Jeremy Lefebvre: BUY PYPL @ $40 - "Undervalued fintech, bottom is in" (<https://youtube.com/watch?v=>...)
Couch Investor: SELL TSLA - "Valuation too stretched, competition rising" (<https://youtube.com/watch?v=>...)
Deep Value Hunter: HOLD SOFI - "Wait for profitability confirmation" (<https://youtube.com/watch?v=>...)

Top 3 Gainers:

META +26.32% - Bitcoin surge to $98K, institutional buying
PLTR +5.88% - New $450M Pentagon AI contract
SOFI +8.94% - Beat earnings, raised FY guidance

Top 3 Losers:

AMZN -5.68% - Missed AWS revenue, guidance disappointing
GOOG -2.22% - Antitrust headlines resurfacing
TSLA -1.85% - Sector rotation out of high-beta names

Market Narrative:
Powell's hawkish tone sparked 2PM selloff but bulls bought the dip into close. Tech bifurcated - semis ripped (AMD +8.4%, NVDA +7.7%) while mega-caps lagged on valuation concerns. Bitcoin breakout above $98K lifted MSTR/CRWV. Defensive sectors weak = risk-on confirmed. Treasury yields settled 4.25% after spike. Watch Tuesday CPI - hot print validates Fed caution. Sentiment: Cautiously bullish but data-dependent.

## Stock WatchList

watchlist:
  stocks:
    - CRM
    - PYPL
    - SOFI
    - GOOG
    - TSLA
    - CAKE
    - META
    - PLTR
    - SHOP
    - EL
    - MSTR
    - PINS
    - BBAI
    - CELH
    - ADBE
    - AMD
    - INTC
    - NVDA
    - AMZN
    - TSM
    - CRWV
  etfs:
    - SPY
    - TQQQ
  indices:
    - TSX
  commodities:
    - XAGUSD
    - AGQ
    - XAUUSD
    - UGL

## News

news_sources:
  twitter:
    - "@federalreserve"
    - "@CNBC"
    - "@Bloomberg"
    - "@zerohedge"
    - "@unusual_whales"
  
  websites:
    - name: Benzinga
      url: <https://www.benzinga.com/news>
      description: Fast breaking market news
  
  rss_feeds:
    - name: CNBC RSS
      url: <https://www.cnbc.com/id/100003114/device/rss/rss.html>
    - name: Reuters RSS
      url: <https://www.reutersagency.com/en/reutersbest/reuters-best-rss/>
    - name: MarketWatch RSS
      url: <https://www.marketwatch.com/rss>
    - name: Yahoo Finance Top Stories
      url: <https://finance.yahoo.com/news/rssindex>
    - name: Yahoo Finance Market News
      url: <https://feeds.finance.yahoo.com/rss/2.0/headline?s=^GSPC&region=US&lang=en-US>
  
  apis:
    - NewsAPI.org
    - Alpha Vantage News
    - Finnhub.io
  
  yahoo_finance:
    news_feed: <https://finance.yahoo.com/news/>
    rss_top_stories: <https://finance.yahoo.com/news/rssindex>
    rss_market_news: <https://feeds.finance.yahoo.com/rss/2.0/headline?s=^GSPC&region=US&lang=en-US>
    rss_ticker_template: <https://feeds.finance.yahoo.com/rss/2.0/headline?s={TICKER}&region=US&lang=en-US>

## Youtuber to watch

youtubers:

- name: Jeremy Lefebvre
  channels:
  - <https://www.youtube.com/@jeremylefebvremakesmoney7934>
  - <https://www.youtube.com/@FinancialEducation>
- name: Couch Investor
  channels:
  - <https://www.youtube.com/@CouchInvestor>
- name: Deep Value Hunter
  channels:
  - <https://www.youtube.com/@DeepValueHunter>
- name: Joseph Carlson
  channels:
  - <https://www.youtube.com/@JosephCarlsonShow>
- name: Ticker Symbol YOU
  channels:
  - <https://www.youtube.com/@TickerSymbolYOU>
- name: Felix & Friends
  channels:
  - <https://www.youtube.com/@FelixFriends>
- name: Parkev Tatevosian CFA
  channels:
  - <https://www.youtube.com/@parkevtatevosiancfa9544>
- name: Ziptrader
  channels:
  - <https://www.youtube.com/@Ziptrader>
- name: Sven Carlin PhD
  channels:
  - <https://www.youtube.com/@Value-Investing>
- name: Adriconomics
  channels:
  - <https://www.youtube.com/@Adriconomics>
- name: Business With Brian
  channels:
  - <https://www.youtube.com/@BusinessWithBrian>
