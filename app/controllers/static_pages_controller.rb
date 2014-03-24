class StaticPagesController < ApplicationController

  def home

  end

  def about_me

  end

  def activity_logging

  end

  def we_help
  end

  def actual_state
    url = 'http://annota-test.fiit.stuba.sk/best_pages/api/tabber_clickeds/clicked_count'
    @counts = HTTParty.get url
  end

  def security

  end

  def installation

  end

  def installation_detailed

  end

  def to_fix

  end

  def feedback

  end


end