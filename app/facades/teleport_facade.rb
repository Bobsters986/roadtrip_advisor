class TeleportFacade

  def self.city_info(destination_city)
    destination = destination_city

    salaries_info = TeleportService.get_salaries(destination_city)

    narrowed_salaries = salaries_info[:salaries].select do |salary|
      salary[:job][:title] == "Data Analyst" || 
      salary[:job][:title] == "Data Scientist" || 
      salary[:job][:title] == "Mobile Developer" || 
      salary[:job][:title] == "QA Engineer" || 
      salary[:job][:title] == "Software Engineer" || 
      salary[:job][:title] == "Systems Administrator" || 
      salary[:job][:title] == "Web Developer"
    end

    salaries = narrowed_salaries.map do |salary|
      {
        title: salary[:job][:title],
        min: "$#{salary[:salary_percentiles][:percentile_25].round(2)}",
        max: "$#{salary[:salary_percentiles][:percentile_75].round(2)}"
      }
    end

    forecast_info = WeatherService.city_name_forecast(destination_city)

    forecast = {
      summary: forecast_info[:current][:condition][:text],
      temperature: "#{forecast_info[:current][:temp_f]} F"
    }

    CityInfo.new(destination, forecast, salaries)
  end

  # def salaries
  #   salaries_info = TeleportService.get_salaries(destination)

  #   narrowed_salaries = salaries_info[:salaries].select do |salary|
  #     salary[:job][:title] == "Data Analyst" || 
  #     salary[:job][:title] == "Data Scientist" || 
  #     salary[:job][:title] == "Mobile Developer" || 
  #     salary[:job][:title] == "QA Engineer" || 
  #     salary[:job][:title] == "Software Engineer" || 
  #     salary[:job][:title] == "Systems Administrator" || 
  #     salary[:job][:title] == "Web Developer"
  #   end

  #   salaries = narrowed_salaries.map do |salary|
  #     {
  #       title: salary[:job][:title],
  #       min: "$#{salary[:salary_percentiles][:percentile_25].round(2)}",
  #       max: "$#{salary[:salary_percentiles][:percentile_75].round(2)}"
  #     }
  #   end
  # end
end

