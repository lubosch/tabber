class GraphsController < ApplicationController

  def index

    @texts = Dir.glob("app/assets/texts/*.txt")

    render 'index'
  end

  def show
    @texts = Dir.glob("app/assets/texts/*.txt")
    @file = params[:file]
    @id = params[:id].to_i

    @col = params[:col].to_i

    @merania = StatReader.read(@file, @col)


    render 'show'
  end

end