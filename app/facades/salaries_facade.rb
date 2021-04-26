class SalariesFacade

  def self.return(destination)
    body = SalariesService.hit_api
    city_array = body[:_links][:"ua:item"]
    link = self.find_urban_area(city_array, destination)
    slug_denver = SalariesService.hit_api_slug(link)
    salaries_link = self.find_salaries_link(slug_denver)
    salaries_body = SalariesService.hit_api_salaries(salaries_link)
    salaries = self.salaries_array(salaries_body)
    require "pry"; binding.pry
  end

  def self.find_urban_area(city_array, destination)
    link = nil
    city_array.each do |hash|
      if hash[:name] == destination
        link = hash[:href]
      end
    end
    link
  end

  def self.find_salaries_link(body)
    body[:_links][:"ua:salaries"][:href]
  end

  def self.salaries_array(body)
    [self.data_analyst(body), self.data_scientist(body), self.mobile_developer(body), self.qa_engineer(body), self.software_engineer(body), self.systems_administrator(body), self.web_developer(body)]
  end

  def self.data_analyst(body)
    job_hash = Hash.new
    body[:salaries].each do |hash|
      if hash[:job][:title] == "Data Analyst"
        job_hash[:title] = "Data Analyst"
        job_hash[:min] = "$#{hash[:salary_percentiles][:percentile_25].round(2)}"
        job_hash[:max] = "$#{hash[:salary_percentiles][:percentile_75].round(2)}"
      end
    end
    job_hash
  end

  def self.data_scientist(body)
    job_hash = Hash.new
    body[:salaries].each do |hash|
      if hash[:job][:title] == "Data Scientist"
        job_hash[:title] = "Data Scientist"
        job_hash[:min] = "$#{hash[:salary_percentiles][:percentile_25].round(2)}"
        job_hash[:max] = "$#{hash[:salary_percentiles][:percentile_75].round(2)}"
      end
    end
    job_hash
  end

  def self.mobile_developer(body)
    job_hash = Hash.new
    body[:salaries].each do |hash|
      if hash[:job][:title] == "Mobile Developer"
        job_hash[:title] = "Mobile Developer"
        job_hash[:min] = "$#{hash[:salary_percentiles][:percentile_25].round(2)}"
        job_hash[:max] = "$#{hash[:salary_percentiles][:percentile_75].round(2)}"
      end
    end
    job_hash
  end

  def self.qa_engineer(body)
    job_hash = Hash.new
    body[:salaries].each do |hash|
      if hash[:job][:title] == "QA Engineer"
        job_hash[:title] = "QA Engineer"
        job_hash[:min] = "$#{hash[:salary_percentiles][:percentile_25].round(2)}"
        job_hash[:max] = "$#{hash[:salary_percentiles][:percentile_75].round(2)}"
      end
    end
    job_hash
  end

  def self.software_engineer(body)
    job_hash = Hash.new
    body[:salaries].each do |hash|
      if hash[:job][:title] == "Software Engineer"
        job_hash[:title] = "Software Engineer"
        job_hash[:min] = "$#{hash[:salary_percentiles][:percentile_25].round(2)}"
        job_hash[:max] = "$#{hash[:salary_percentiles][:percentile_75].round(2)}"
      end
    end
    job_hash
  end

  def self.systems_administrator(body)
    job_hash = Hash.new
    body[:salaries].each do |hash|
      if hash[:job][:title] == "Systems Administrator"
        job_hash[:title] = "Systems Administrator"
        job_hash[:min] = "$#{hash[:salary_percentiles][:percentile_25].round(2)}"
        job_hash[:max] = "$#{hash[:salary_percentiles][:percentile_75].round(2)}"
      end
    end
    job_hash
  end


  def self.web_developer(body)
    job_hash = Hash.new
    body[:salaries].each do |hash|
      if hash[:job][:title] == "Web Developer"
        job_hash[:title] = "Web Developer"
        job_hash[:min] = "$#{hash[:salary_percentiles][:percentile_25].round(2)}"
        job_hash[:max] = "$#{hash[:salary_percentiles][:percentile_75].round(2)}"
      end
    end
    job_hash
  end

end
