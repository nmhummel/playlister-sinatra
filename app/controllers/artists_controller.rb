class ArtistsController < ApplicationController

    get '/artists' do
        @artists = Artist.all
        erb:'artists/index'
    end
    
    get '/artists/:slug' do
        @artist = Artist.find_by_slug(params[:slug])
        @song = Song.all.select{|song| song.artist_id == @artist.id}[0]
        @song_genre = SongGenre.all.select{|song|song.song_id == @song.id}[0]
        @genre = Genre.find_by_id(@song_genre.genre_id)
        erb :'/artists/show'
    end

    get '/artists/:id' do
        @artist = Artist.find_by(params[:id])
        erb :show
    end

end
