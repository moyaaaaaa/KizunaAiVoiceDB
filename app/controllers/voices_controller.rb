require 'shellwords'
require 'open3'

class VoicesController < ApplicationController
  before_action :fetch_voices, only: :index
  before_action :set_voice, only: [:show, :edit, :update, :destroy]
  before_action :allow_youtube_iframe, only: [:show]

  # GET /voices
  # GET /voices.json
  def index; end

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

  # POST /voices
  # POST /voices.json
  def create
    @voice = Voice.new(voice_params)
    output_filepath = download_voice(params[:voice][:url])
    File.open("#{Rails.root}/#{output_filepath}") do |f|
      @voice.voice_file = f
    end
    o, e, s = Open3.capture3("wget -nv --delete-after '#{@voice.url}'")
    e.chomp =~ /.*URL:(.*) \[.*\] -> /
    @voice.url = Regexp.last_match(1)
    return render :edit if @voice.invalid?
    @voice.save!

    system("rm #{output_filepath}")

    flash[:success] = 'Voice was successfully created.'
    redirect_to voices_path
  end

  # GET /voices/1/edit
  def edit; end

  # PATCH/PUT /voices/1
  # PATCH/PUT /voices/1.json
  def update
    @voice.assign_attributes(voice_params)
    output_filepath = download_voice(params[:voice][:url])
    File.open("#{Rails.root}/#{output_filepath}") do |f|
      @voice.voice_file = f
    end
    o, e, s = Open3.capture3("wget -nv --delete-after '#{@voice.url}'")
    e.chomp =~ /.*URL:(.*) \[.*\] -> /
    @voice.url = Regexp.last_match(1)
    respond_to do |format|
      if @voice.save
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

    def fetch_voices
      @q = Voice.ransack(params[:q])
      @voices = @q.result
                  .page(params[:page])
                  .per(30)
                  .order(created_at: :desc)
    end

    def download_voice(url)
      output_filepath = 'public/out.m4a'
      get_url_cmd = "youtube-dl --get-url #{Shellwords.escape(url)}"
      logger.info get_url_cmd
      o, e, s = Open3.capture3(get_url_cmd)
      sound_url = o.split(/\R/).second
      logger.info "ffmpeg -y -ss #{params[:voice][:start]} -t #{params[:voice][:during]} -i '#{sound_url}' #{output_filepath}"
      Open3.capture3 "ffmpeg -y -ss #{params[:voice][:start]} -t #{params[:voice][:during]} -i '#{sound_url}' #{output_filepath}"
      output_filepath
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_voice
      @voice = Voice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def voice_params
      params.require(:voice).permit(:id, :voice_file, :voice_file_cache, :line, :url, :start, :during)
    end

    def allow_youtube_iframe
      response.headers['X-Frame-Options'] = 'ALLOW-FROM https://www.youtube.com'
      response.headers['Content-Security-Policy'] = 'frame-ancestors https://www.youtube.com'
    end
end
