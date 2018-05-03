require_relative '../../lib/env'
require_relative '../../lib/base'

class FreelancerPage < Base

  FREELANCER_DATA = { css: 'div.media' }
  NAME = { css: '#optimizely-header-container-default [itemprop="name"]' }
  TITLE = { css: '[data-ng-if="vm.vpd.profile.title"] span.ng-binding' }
  DESCRIPTION = { css: '.ng-hide[ng-show="open"]' }
  SKILLS = { css: '[data-ng-repeat*="skill in items"]' }

  def initialize(driver)
    super
    verify_page
  end

  def get_freelancer_data
    skills_arr = []

    wait_for { displayed? FREELANCER_DATA }
    name = text_of NAME
    title = text_of TITLE
    overview = text_of DESCRIPTION
    skills_ele = find_all SKILLS

    skills_ele.each { |skill|
      skills = skill.text.split(',')
      skills_arr.push(skills)
    }

    @freelancer_data = {}
    @freelancer_data['name'] = name
    @freelancer_data['title'] = title
    @freelancer_data['overview'] = overview
    @freelancer_data['skills'] = skills_arr

    puts "Freelancer data: #{@freelancer_data}"
  end

  def is_freelancer_data_equal?
    name = text_of NAME
    @info_arr.each do |hash|
      puts "Hash from results: #{hash}"
      if hash['name'] == name
        puts "Test Passed: Data is present on the freelancer's page" if @freelancer_data == hash
        else puts "Test Failed: Data isn't present on the freelancer's page"
      end
    end
  end

  private

  def verify_page
    page_loaded?
    wait_for { displayed? FREELANCER_DATA }
  end
end