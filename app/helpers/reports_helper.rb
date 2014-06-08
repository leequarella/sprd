module ReportsHelper
  def date_to_params date
    {
      "date(1i)" => date.year,
      "date(2i)" => date.month,
      "date(3i)" => date.day
    }
  end
end
