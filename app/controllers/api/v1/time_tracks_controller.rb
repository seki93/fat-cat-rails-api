class Api::V1::TimeTracksController < ApplicationController

  def show
    time_track = TimeTrack.find(params[:id])
    render json: time_track
  end

  def create
    time_track = TimeTrack.new(time_track_params)
    if time_track.save
      render json: time_track, status: :created
    else
      render json: time_track.errors, status: :unprocessable_entity
    end
  end

  def update
    time_track = TimeTrack.find(params[:id])
    if time_track
      time_track.update(time_track_params)
      render json: { message: 'TimeTrack successfully updated' }, status: :ok
    else
      render json: { error: 'Unable to update TimeTrack.' }, status: :bad_request
    end
  end

  def report
    render json: ReportRepresenter.new(params[:user_id], params[:report_type]).report
  end

  private

  def time_track_params
    params.require(:time_track).permit(:user_id, :start_time, :end_time)
  end

end
