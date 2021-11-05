class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get "/words" do
    Word.all.to_json(include: [:comments])
  end

  get "/words/random" do
    word = Word.random
    word.to_json(include: [:comments])
  end

  get "/words/:id" do
    word = Word.find(params[:id])
    word.to_json(include: [:comments])
  end

  get "/comments" do
    comments = Comment.all
    comments.to_json
  end

  get "/comments/:id" do
    comment = Comment.find(params[:id])
    comment.to_json
  end

  post "/words" do
    new_word = Word.create(
      word: params[:words],
      user: params[:user]
    )
    new_word.to_json(include: [:comments])
  end

  post "/words/:id" do
    new_comment = Comment.create(
      comment: params[:comment],
      user: params[:user],
      word_id: params[:id]
    )
    new_comment.to_json
  end

  delete '/comments/:id' do
    comment = Comment.find(params[:id])
    comment.destroy
    comment.to_json
  end

  delete '/words/:id' do
    word = Word.find(params[:id])
    word.destroy
    word.to_json(include: [:comments])
  end

end
