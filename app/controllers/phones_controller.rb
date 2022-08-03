# frozen_string_literal: true

class PhonesController < ApplicationController
  before_action :set_phone, only: %i[show edit update destroy]
  before_action :set_user
  # GET /phones or /phones.json
  def index
    @phones = Phone.all
  end

  # GET /phones/1 or /phones/1.json
  def show; end

  # GET /phones/new
  def new
    @phone = Phone.new
  end

  # GET /phones/1/edit
  def edit; end

  # POST /phones or /phones.json
  def create
    @phone = current_user.phones.build(phone_params)

    respond_to do |format|
      if @phone.save
        format.html { redirect_to user_phone_url(@user, @phone), notice: 'Phone was successfully created.' }
        format.json { render :show, status: :created, location: @phone }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phones/1 or /phones/1.json
  def update
    respond_to do |format|
      if @phone.update(phone_params)
        format.html { redirect_to user_phone_url(@user, @phone), notice: 'Phone was successfully updated.' }
        format.json { render :show, status: :ok, location: @phone }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @phone = @user.phones.find(params[:id])
    @phone.destroy
    redirect_to user_phones_path(@user), status: 303
  end

  # DELETE /phones/1 or /phones/1.json

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:user_id])
  end

  def set_phone
    @phone = Phone.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def phone_params
    params.require(:phone).permit(:phone, :country, :user_id)
  end
end
