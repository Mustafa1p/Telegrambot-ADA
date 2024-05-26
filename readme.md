# Telegram Google Search Bot

This is a Telegram bot written in Ada that uses the Google Custom Search API to search the web and return links and titles in chat.

## Prerequisites

- GNAT Ada compiler
- GNATColl libraries
- A Telegram bot token from [BotFather](https://t.me/botfather)
- A Google Custom Search API key and Search Engine ID

## Setup

1. **Install GNAT Ada Compiler**:
   - Download and install GNAT from [AdaCore](https://www.adacore.com/download).
   
2. **Install GNATColl Libraries**:
   - Follow the installation instructions for GNATColl at [AdaCore GNATColl](https://www.adacore.com/download).

3. **Create a Telegram Bot**:
   - Talk to [BotFather](https://t.me/botfather) on Telegram to create a new bot and get the API token.

4. **Get Google API Credentials**:
   - Obtain a Google Custom Search API key and create a Custom Search Engine (CSE) from the [Google Developer Console](https://console.developers.google.com/).

## Configuration

Replace the placeholders in the `telegram_bot.adb` file with your actual credentials:

```ada
Token : constant String := "YOUR_TELEGRAM_BOT_TOKEN";
Google_API_Key : constant String := "YOUR_GOOGLE_API_KEY";
Search_Engine_ID : constant String := "YOUR_SEARCH_ENGINE_ID";

Compilation and Execution

	1.	Compile the Ada Code:
	•	Navigate to your project directory.
	•	Use the GNAT compiler to compile the code:

gnatmake tele.adb

Run the Bot:
	•	Execute the compiled program:

./tele


This ada code was developer by Mustafa ip | First ada bot in wolrd for telegram search engine 
