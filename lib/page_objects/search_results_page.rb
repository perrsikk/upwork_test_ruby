require_relative '../../lib/env'
require_relative '../../lib/base'

class SearchResultsPage < Base

  TITLE = { id: 'oSearchContractorsHeader' }
  SEARCH_RESULTS = { id: 'oContractorResults' }
  FREELANCERS = { css: 'section[data-log-sublocation="search_results"]' }
  FREELANCER_NAME = { css: 'a[data-qa="tile_name"]' }
  FREELANCER_TITLE = { css: 'h4[data-qa="tile_title"]' }
  FREELANCER_OVERVIEW = { class: 'freelancer-tile-description' }
  FREELANCER_SKILLS = { css: '[data-log-label="tile_skill"] span' }
  FREELANCER_BOX = { css: '[data-qa="freelancer"]' }

  def initialize(driver)
    super
    verify_page
  end

  def get_freelancers_info
    @info_arr = []
    skills_arr = []

    arr = find_all FREELANCERS

    arr.each { |freelancer|
      name_ele = freelancer.find_element FREELANCER_NAME
      name = name_ele.text

      title_ele = freelancer.find_element FREELANCER_TITLE
      title = title_ele.text

      overview_ele = freelancer.find_element FREELANCER_OVERVIEW
      overview = overview_ele.text

      skills_ele = freelancer.find_elements FREELANCER_SKILLS
      skills_ele.each { |skill|
        skills = skill.text.split(',')
        skills_arr.push(skills)
      }

      hash = {}
      hash['name'] = name
      hash['title'] = title
      hash['overview'] = overview
      hash['skills'] = skills_arr

      @info_arr.push(hash)
    }
    puts @info_arr
  end

  def freelancers_has_value?(search_term)
    @info_arr.each do |hash|
      hash.each_pair do |key, value|
        if value.include? search_term
          $stdout.puts "Freelancer: #{hash['name']} contains #{search_term} in the #{key}"
        else
          $stdout.puts "Freelancer: #{hash['name']} do not contains #{search_term} in the #{key}"
        end
      end
    end
  end

  def open_random_freelancer
    length = @info_arr.length
    num = rand(1..length)
    puts "num: #{num}"
    freelancer_box = find(FREELANCER_BOX)
    rand_freelancer = freelancer_box.find_element(:css, ":nth-child(#{num}) .freelancer-tile-name")
    rand_freelancer.click
  end


  private

  def verify_page
    page_loaded?
    wait_for { displayed?(SEARCH_RESULTS) }
  end
end