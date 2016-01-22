# Subtle
_Improve your knowledge of the english language by learning new words used in your favourite TV Shows and movies_

![image](http://cl.ly/000w3h0E2Q0R/Schermata%202016-01-22%20alle%2016.44.03.png)

__Subtle__ is a simple Ruby command-line program that analyze [SubRip](https://en.wikipedia.org/wiki/SubRip#SubRip_text_file_format) subtitles files. It extracts all the unique words and check these agains a local dictionary of common words. The entries not found in the dictionary are translated from English to Italian (or a language of your choice).

## Installation

1. Download the `subtle.rb` script and the `dictionary.txt`file;
2. Install the Google API gem `$ gem install google-api-client`;
3. Obtain a key from Google to use their API;
4. Write the key in a filename called `api.key`;
5. Enable billing on Google Developer Console to be able to call the Translate API;

## Usage

Run the script with the following command:

	$ subtle.rb filename.srt

The program produces to file output:

- `filename.srt.dictionary.txt` with the list of new words, that can be manually added to the main dictionary;
- `filename.srt.translations.txt`with the list of translations as showed in the screenshot above.

### Contact
[http://bigatti.it](http://bigatti.it)  
[@mbigatti](https://twitter.com/mbigatti)
