class ReportRepresenter

  attr_reader :user_id, :type

  REPORT_TYPE = {
      'daily' => DateTime.current.beginning_of_day..DateTime.current.end_of_day,
      'weekly' => DateTime.current.beginning_of_week..DateTime.current.end_of_week
  }

  def initialize(user_id, type)
    @user_id = user_id
    @type = type
  end

  def report
    TimeTrack.where(user_id: user_id, start_time: REPORT_TYPE[type]).map do |report|
      {
          id: report.id,
          start_time: report.start_time,
          end_time: report.end_time,
          total: (report.end_time - report.start_time) / 60
      }
    end
  end

end