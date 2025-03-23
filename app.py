import streamlit as st
import pandas as pd
import requests
import plotly.graph_objects as go
from datetime import datetime, timedelta

st.set_page_config(
    page_title="Crypto Tracker",
    page_icon="📈",
    layout="wide"
)

# App title and description
st.title("📈 Crypto Price Tracker")
st.markdown("""
This app retrieves cryptocurrency prices for the top 100 cryptocurrencies from the **CoinGecko API**!
""")

# Create three columns
col1, col2, col3 = st.columns(3)

# Function to get crypto data
@st.cache_data(ttl=300)  # Cache the data for 5 minutes
def get_crypto_data():
    url = "https://api.coingecko.com/api/v3/coins/markets"
    params = {
        "vs_currency": "usd",
        "order": "market_cap_desc",
        "per_page": 100,
        "page": 1,
        "sparkline": False
    }
    response = requests.get(url, params=params)
    data = response.json()
    return pd.DataFrame(data)

# Get the data
try:
    df = get_crypto_data()

    # Display metrics in columns
    with col1:
        st.metric(
            label=f"Bitcoin (BTC)",
            value=f"${df[df['id'] == 'bitcoin']['current_price'].iloc[0]:,.2f}",
            delta=f"{df[df['id'] == 'bitcoin']['price_change_percentage_24h'].iloc[0]:.2f}%"
        )

    with col2:
        st.metric(
            label=f"Ethereum (ETH)",
            value=f"${df[df['id'] == 'ethereum']['current_price'].iloc[0]:,.2f}",
            delta=f"{df[df['id'] == 'ethereum']['price_change_percentage_24h'].iloc[0]:.2f}%"
        )

    with col3:
        st.metric(
            label=f"Total Market Cap",
            value=f"${df['market_cap'].sum():,.0f}",
            delta=f"{df['price_change_percentage_24h'].mean():.2f}%"
        )

    # Create a table with the top 100 cryptocurrencies
    st.subheader("Top 100 Cryptocurrencies")
    
    # Format the dataframe
    df_display = df[['name', 'symbol', 'current_price', 'market_cap', 'price_change_percentage_24h']].copy()
    df_display.columns = ['Name', 'Symbol', 'Price (USD)', 'Market Cap', '24h Change (%)']
    df_display['Price (USD)'] = df_display['Price (USD)'].map('${:,.2f}'.format)
    df_display['Market Cap'] = df_display['Market Cap'].map('${:,.0f}'.format)
    df_display['24h Change (%)'] = df_display['24h Change (%)'].map('{:,.2f}%'.format)
    
    st.dataframe(df_display, use_container_width=True)

except Exception as e:
    st.error(f"Error fetching data: {e}")
    st.warning("Note: CoinGecko API has rate limits. Please wait a few minutes if you exceed the limit.")