require_relative '../../lib/env'
require_relative '../../lib/base'

class FreelancerPage < Base

  FREELANCER_DATA = { id: 'optimizely-header-container-default' }
  NAME = { css: '#optimizely-header-container-default [itemprop="name"]' }
  TITLE = { css: '[data-ng-if="vm.vpd.profile.title"] span.ng-binding' }
  DESCRIPTION = { css: '.ng-hide[ng-show="open"]' }
  SKILLS = { css: '[data-ng-repeat*="skill in items"]' }

  def initialize(driver)
    super
    verify_page
  end

  def get_freelancers_info
    wait
    @freelancer_info_arr = []
    skills_arr = []

    name_ele = find NAME
    name = name_ele.text

    title_ele = find TITLE
    title = title_ele.text

    overview_ele = find DESCRIPTION
    overview = overview_ele.text

    skills_ele = find SKILLS
    skills_ele.each { |skill|
      skills = skill.text.split(',')
      skills_arr.push(skills)
    }

    hash = {}
    hash['name'] = name
    hash['title'] = title
    hash['overview'] = overview
    hash['skills'] = skills_arr

    @freelancer_info_arr.push(hash)

    puts "info: #{@freelancer_info_arr}"
  end

  def is_freelancer_data_equal?
    get_freelancers_info
    name = text_of NAME
    @info_arr.each do |hash|
      if hash['name'] == name
        @freelancer_info_arr == hash
      end
    end
  end

  private

  def verify_page
    page_loaded?
    wait_for { displayed?(FREELANCER_DATA) }
  end
end