class GenresController < ApplicationController
   
    get '/genres' do
        @genres = Genre.all
        erb :'/genres/index'
    end


    get '/genres/:slug' do
        @genre = Genre.find_by_slug(params[:slug])
        @song_genre = SongGenre.all.select{|genre| genre.genre_id == @genre.id}[0]
        @song = Song.find_by_id(@song_genre.song_id)
        @artist = Artist.find_by_id(@song.artist_id)

        erb :'/genres/show'

    end

    get '/genres/:id' do
        @genre = Genre.find_by(params[:id])
        erb :'/genres/show'
    end

end