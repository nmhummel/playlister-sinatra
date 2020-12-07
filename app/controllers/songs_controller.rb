require 'rack-flash'
class SongsController < ApplicationController
    use Rack::Flash

    get '/songs' do
        @songs = Song.all
        erb :'/songs/index'
    end

    get '/songs/new' do
        @artists = Artist.all
        erb :'/songs/new'
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        #@artist = @song.artist
        #@song_genre = SongGenre.all.select{|song|song.song_id == @song.id}[0]
        #@genre = Genre.find_by_id(@song_genre.genre_id)
        erb :'/songs/show'
    end

    post '/songs' do
        @artists = Artist.all
        @song = Song.create(params["song"])
        @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
        @song.genre_ids = params[:genres]
        @song.save
        flash[:message] = "Successfully created song."
        redirect "/songs/#{@song.slug}"
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        erb :'/songs/edit'
    end

    patch '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        @artist_hash = params[:song][:artist]
        @song.artist = Artist.find_or_create_by(name: @artist_hash[:name])
        genre_id = params[:song][:genres]
        @genre = Genre.find_by_id(genre_id)    
        @song.genres << @genre
        @song.save
        flash[:message] = "Successfully updated song."
        redirect "/songs/#{@song.slug}"
    end

    get '/songs/:id' do
        @song = Song.find_by(params[:id])
        erb :show
    end



end