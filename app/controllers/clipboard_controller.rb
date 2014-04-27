class ClipboardController < ActionController::Base

  def pasted
    user = User.find(params[:user_id]) if params[:user_id]
    s = Software.find_by_process(params[:process_name]) if params[:process_name]
    if user && s && params[:text]
      ClipboardPaste.create(:user => user, :software => s, :text => params[:text])
    end

    render :status => 200

  end

  def copied
    user = User.find(params[:user_id]) if params[:user_id]
    s = Software.find_by_process(params[:process_name]) if params[:process_name]
    if user && s && params[:text]
      ClipboardCopy.create(:user => user, :software => s, :text => params[:text])
    end

    render json: {:status => 200}

  end


end