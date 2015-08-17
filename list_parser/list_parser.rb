require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'xml'
require 'open-uri'

games = {}

def get_games
    #raw_xml = open("http://www.boardgamegeek.com/xmlapi/geeklist/174654").read
    raw_xml = open("174654.xml").read

    # Parse the XML with LibXml
    # (this is where the magic happens)
    source = XML::Parser.string(raw_xml) # source.class => LibXML::XML::Parser
    content = source.parse # content.class => LibXML::XML::Document

    # If you look at the XML from FriendFeed, each entry is contained in <entry> tags
    items = content.root.find('./item') # entries.class => LibXML::XML::XPath::Object

    items.each do |item| # entry.class => LibXML::XML::Node
        # This returns whatever's contained in the entry's <title> tags
        # E.g. <title>140 characters of wisdom</title>
        #print item.attributes.methods.sort
        game_name = item.attributes.get_attribute("objectname")
        game_id = item.attributes.get_attribute("objecid")
        game_image_id = item.attributes.get_attribute("imageid")
        publisher_id = item.attributes.get_attribute("publisherid")

        print  image_url = "\nhttp://cf.geekdo-images.com/images/pic#{game_image_id.value}_sq.jpg\n"
        # # This returns whatever's within the <id> tags inside the <service> tags
        # # E.g. <service><id>twitter</id></service>
        # short_name = entry.find_first('service/id').content

        # # Same for <long_name> and <url> tags inside <service>
        # long_name = entry.find_first('service/name').content
        # url = entry.find_first('service/profileUrl').content

        # # Do something with the data...
        # # E.g. source = Source.find_or_create_by_short_name_and_long_name(short_name, long_name)
        # # new_post.update_attribute(:source_id, source.id)
    end
    return "foo"
end

get '/' do
  "Spiel Essen"
end

get '/games' do
    get_games
end