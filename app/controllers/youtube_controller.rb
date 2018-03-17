require 'uri'
require 'nokogiri'
require 'open-uri'

class YoutubeController < ApplicationController
  protect_from_forgery except: %i[:timed_text]

  def timed_text
    puts params[:url]

    uri = URI::parse(params[:url])
    video_id = Hash[URI::decode_www_form(uri.query)]['v']

    xml = Nokogiri::XML(open("http://video.google.com/timedtext?type=list&v=#{video_id}").read)
    item_nodes = xml.xpath('//track')
    puts item_nodes


    ja_track = item_nodes.find { |item| item.attributes['lang_code'].value == 'ja' }
    # ja_track.nil? ならreturn

    xml = Nokogiri::XML(open("http://video.google.com/timedtext?hl=ja&lang=ja&v=#{video_id}").read)
    item_nodes = xml.xpath('//text')


    respond_to do |format|
      format.xml { render :xml => xml}
    end


    #http://video.google.com/timedtext?type=list&v=v79HxnWIuNY

    #http://video.google.com/timedtext?hl=ja&lang=ja&v=v79HxnWIuNY




  end

  private

    def hasJapaneseTrack?(url)
      url = "http://video.google.com/timedtext?type=list&v=#{video_id}"
      xml = Nokogiri::XML(open(url).read)
      item_nodes = xml.xpath('//track')
      item_nodes.find { |item|
        item.attributes['lang_code'].value == 'ja'
      }.present?
    end

    def video_id
      uri = URI::parse(params[:url])
      Hash[URI::decode_www_form(uri.query)]['v']
    end
end