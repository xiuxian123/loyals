# -*- encoding : utf-8 -*-
module LoyalAdmin
  class Display::BoardsController < ::LoyalAdmin::ApplicationController
    def index
      @boards = ::LoyalAdmin::Display::Board.page(params[:page]).per(30)
    end

    def show
      @board = ::LoyalAdmin::Display::Board.find params[:id]
    end

    def new
      @board = ::LoyalAdmin::Display::Board.new
    end

    def create
      @board = ::LoyalAdmin::Display::Board.new(params[:display_board])

      if @board.save
        redirect_to loyal_admin_app.display_board_url(:id => @board.id)
      else
        render :new
      end
    end

    def edit
      @board = ::LoyalAdmin::Display::Board.find params[:id]
    end

    def update
      @board = ::LoyalAdmin::Display::Board.find params[:id]

      if @board.update_attributes(params[:display_board])
        redirect_to loyal_admin_app.display_board_url(:id => @board.id)
      else
        render :edit
      end
    end

    def destroy
      @board = ::LoyalAdmin::Display::Board.find params[:id]

      @board.destroy

      redirect_to params[:return_to] || loyal_admin_app.display_boards_url
    end

  end
end
