require 'shellwords'

class VoicesController < ApplicationController
  before_action :set_voice, only: [:show, :edit, :update, :destroy]

  # GET /voices
  # GET /voices.json
  def index
    @voices = Voice.all
  end

  # GET /voices/1
  # GET /voices/1.json
  def show
  end

  # GET /voices/new
  def new
    @voice = Voice.new


    url = 'http://video.google.com/timedtext?lang=ja&v=COXCojRKbk8'

    xml = Nokogiri::XML(open(url).read)

    texts = xml.xpath('//text')

    texts.each do |text|
      text.attributes['start'].value
      text.attributes['dur'].value
      text.text
    end
  end

  # GET /voices/1/edit
  def edit
  end

  # POST /voices
  # POST /voices.json



  def create
    # youtube-dl -f m4a "https://www.youtube.com/watch?v=v79HxnWIuNY"
    #YoutubeDL.download(params[:url], format: 'm4a', output: 'temp.m4a')
    #YoutubeDL.download "https://www.youtube.com/watch?v=gvdf5n-zI14", output: 'some_file.mp4'

    input_filepath = 'public/uploads/tmp/tmp.m4a'
    output_filepath = 'public/uploads/tmp/out.m4a'
    puts Shellwords.escape(params[:voice][:url])
    puts "youtube-dl -o \"#{input_filepath}\" -f m4a #{Shellwords.escape(params[:voice][:url])}"
    system("youtube-dl -o \"#{input_filepath}\" -f m4a #{Shellwords.escape(params[:voice][:url])}")
    puts "ffmpeg -y -i #{input_filepath} -ss #{params[:voice][:start]} -t #{params[:voice][:during]} #{output_filepath}"
    system("ffmpeg -y -i #{input_filepath} -ss #{params[:voice][:start]} -t #{params[:voice][:during]} #{output_filepath}")

    voice = Voice.new(voice_params)
    File.open("#{Rails.root}/#{output_filepath}") do |f|
      voice.voice_file = f
    end
    #VoiceUploader.new.store!(open("#{output_filepath}"))
    voice.save!

    puts voice.voice_file.url
    system("rm #{input_filepath}")
    system("rm #{output_filepath}")


    flash[:success] = 'Voice was successfully created.'
    redirect_to voices_path
  end

  # PATCH/PUT /voices/1
  # PATCH/PUT /voices/1.json
  def update
    respond_to do |format|
      if @voice.update(voice_params)
        flash[:success] = 'Voice was successfully updated.'
        format.html { redirect_to voices_path }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /voices/1
  # DELETE /voices/1.json
  def destroy
    @voice.remove_voice_file!
    @voice.destroy
    respond_to do |format|
      format.html { redirect_to voices_url, notice: 'Voice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_voice
      @voice = Voice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def voice_params
      params.require(:voice).permit(:id, :voice_file, :voice_file_cache, :line, :url, :start, :during)
    end
end
