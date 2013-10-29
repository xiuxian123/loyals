# -*- encoding : utf-8 -*-
module LoyalAdmin
  class Display::BoardsController < ::LoyalAdmin::ApplicationController
    before_action :set_board, :only => [:show, :edit, :update, :destory]

    def index
      @boards = ::LoyalAdmin::Display::Board.page(params[:page]).per(30)
    end

    def show
    end

    def new
      @board = ::LoyalAdmin::Display::Board.new
    end

    def create
      @board = ::LoyalAdmin::Display::Board.new(board_params)

      if @board.save
        redirect_to loyal_admin_app.display_board_url(:id => @board.id)
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @board.update_attributes(board_params)
        redirect_to loyal_admin_app.display_board_url(:id => @board.id)
      else
        render :edit
      end
    end

    def destroy
      @board.destroy

      redirect_to params[:return_to] || loyal_admin_app.display_boards_url
    end

  protected

    def set_board
      @board = ::LoyalAdmin::Display::Board.find params[:id]
    end

    def board_params
      params[:board].permit(:name, :space, :permalink, :instroduction, :description, :item_ids, :short_name, :parent_id)
    end

  end
end
