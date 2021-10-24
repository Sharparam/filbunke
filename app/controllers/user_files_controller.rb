# frozen_string_literal: true

class UserFilesController < ApplicationController
  before_action :load_user_file, only: %i[show edit update destroy]
  before_action :set_user_file, only: %i[new]
  load_and_authorize_resource find_by: :uuid

  # GET /files or /files.json
  def index; end

  # GET /files/1 or /files/1.json
  def show; end

  # GET /files/new
  def new; end

  # GET /files/1/edit
  def edit; end

  # POST /files or /files.json
  def create
    @user_file.uuid ||= SecureRandom.uuid
    respond_to do |format|
      if @user_file.save
        format.html { redirect_to @user_file, notice: 'User file was successfully created.' }
        format.json { render :show, status: :created, location: @user_file }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /files/1 or /files/1.json
  def update
    respond_to do |format|
      if @user_file.update(user_file_params)
        format.html { redirect_to @user_file, notice: 'User file was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_file }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /files/1 or /files/1.json
  def destroy
    @user_file.destroy
    respond_to do |format|
      format.html { redirect_to user_files_url, notice: 'User file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user_file
    @user_file = current_user.user_files.build
  end

  def load_user_file
    @user_file = UserFile.find_by!(uuid: params[:uuid])
  end

  # Only allow a list of trusted parameters through.
  def user_file_params
    params.require(:user_file).permit(:file, :visibility)
  end
end
