require 'rails_helper'

RSpec.describe "Api::V1::TimeTracks", type: :request do
  describe 'POST /time_tracks' do
    it 'create a new time_track' do
      FactoryBot.create(:user, id: 1, username: 'John', password: 'password')
      expect{
        post '/api/v1/time_tracks', params:
            { time_track:
                  { start_time: '2021-08-18 15:15:15', end_time: nil, user_id: 1 }
            }
      }.to change { TimeTrack.count }.from(0).to(1)
    end
  end

  describe 'PUT /time_tracks' do
    it 'update existing time_track' do
      FactoryBot.create(:user, id: 1, username: 'John', password: 'password')
      FactoryBot.create(:time_track, id: 1, start_time: '2021-08-18 15:15:15', end_time: nil, user_id: 1)

      put '/api/v1/time_tracks', params: { time_track: { end_time: '2021-08-18 16:15:15', user_id: 1 }, id: 1 }

      expect(TimeTrack.find(1).end_time).to eq('2021-08-18 16:15:15'.to_datetime)
    end
  end

  describe 'GET /time_tracks/report' do

    before do
      travel_to Time.local(2021, 8, 18, 17, 17)
    end

    after do
      travel_back
    end
    it 'get daily time_tracks' do
      FactoryBot.create(:user, id: 1, username: 'John', password: 'password')
      FactoryBot.create(:time_track, id: 1, start_time: '2021-08-18 15:15:15', end_time: '2021-08-18 16:15:15', user_id: 1)

      get '/api/v1/time_tracks/report', params: { user_id: 1, report_type: 'daily' }

      expect(JSON.parse(response.body)).to eq(
                                               [
                                                   {
                                                       "id" => 1,
                                                       "start_time" => '2021-08-18 15:15:15 UTC',
                                                       "end_time" => '2021-08-18 16:15:15 UTC',
                                                       "total" => 60.0
                                                   }
                                               ]
                                           )
    end

    it 'get weekly time_tracks' do
      FactoryBot.create(:user, id: 1, username: 'John', password: 'password')
      FactoryBot.create(:time_track, id: 1, start_time: '2021-08-17 15:15:15', end_time: '2021-08-17 16:15:15', user_id: 1)
      FactoryBot.create(:time_track, id: 2, start_time: '2021-08-16 15:15:15', end_time: '2021-08-16 16:15:15', user_id: 1)

      get '/api/v1/time_tracks/report', params: { user_id: 1, report_type: 'weekly'}

      expect(JSON.parse(response.body).size).to eq(2)
    end
  end
end
