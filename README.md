# Newsboat RSS URL file to FreshRSS format converter

This is just a simple script written in bash due to me trying `FreshRSS` on `Docker` and wanted to import all my URLs from my already long list of URLs I was using in `Newsboat` but didn't want to copy all one by one as I would take me ages to do that.

## What you need from FreshRSS

You have to export your URLs from FreshRSS to have the template where you are going to add the new links. Make sure to tick [x] __"Export list of feeds"__.

The file will look something like this:

```opml
<?xml version="1.0" encoding="UTF-8"?>
<opml xmlns:frss="https://freshrss.org/opml" version="2.0">
  <head>
    <title>FreshRSS</title>
    <dateCreated>Thu, 19 Oct 2023 16:41:17 +0200</dateCreated>
  </head>
  <body>    
    <outline text="Uncategorized">
      <outline text="FreshRSS releases" type="rss" xmlUrl="https://github.com/FreshRSS/FreshRSS/releases.atom" htmlUrl="https://github.com/FreshRSS/FreshRSS/" description="FreshRSS releases @ GitHub"/>
    </outline>
    <outline text="Youtube">
      <outline text="Jeff Geerling" type="rss" xmlUrl="https://www.youtube.com/feeds/videos.xml?channel_id=UCR-DXc1voovS8nhAvccRZhg" htmlUrl="https://www.youtube.com/channel/UCR-DXc1voovS8nhAvccRZhg" description=""/>    
    </outline>
  </body>
</opml>
```

"Uncategorized" is created by default and I have created a new category called "Youtube" and added [Jeff Geerling's channel](https://www.youtube.com/c/JeffGeerling) through the GUI.

The rest of the channels will go under that one.

## Newsboat URLs file

On Newsboat you could have lines starting with `"---"` meaning they are just separators so you could list your feed in the terminal in a prettier way. Those lines will be ignored. URL lines starting with `"#"` will be ignored too as that would mean you had them disabled.

The way I have my Newsboat file looks like as follows:

```
-----------------
-----YOUTUBE-----
-----------------
# Jeff Geerling
https://www.youtube.com/feeds/videos.xml?channel_id=UCR-DXc1voovS8nhAvccRZhg "~YOUTUBE: Jeff Geerling"
# Jeff Geerling - Geerling engineering
https://www.youtube.com/feeds/videos.xml?channel_id=UCsd6hP-zzIkCpw8XGw7Osyw "~YOUTUBE: Geerling Engeneering"
# Commented out url
#https://www.google.com
```

First line in pairs will be the `Channel Name` and the second one the `XML Url`.

## Usage

```
$ main.sh newsboat_url_file > output
```

Running my example Newsboat will create the following output which you can then copy and paste into your exported FreshRSS file `feeds_date.opml.xml`:

```
      <outline text="Jeff Geerling" type="rss" xmlUrl="https://www.youtube.com/feeds/videos.xml?channel_id=UCR-DXc1voovS8nhAvccRZhg" htmlUrl="https://www.youtube.com/channel/UCR-DXc1voovS8nhAvccRZhg" description=""/>
      <outline text="Jeff Geerling - Geerling engineering" type="rss" xmlUrl="https://www.youtube.com/feeds/videos.xml?channel_id=UCsd6hP-zzIkCpw8XGw7Osyw" htmlUrl="" description=""/>   
```