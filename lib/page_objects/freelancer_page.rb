require_relative '../../lib/env'
require_relative '../../lib/base'

class FreelancerPage < Base

  FREELANCER_DATA = { css: 'div.media' }
  NAME = { css: '#optimizely-header-container-default [itemprop="name"]' }
  TITLE = { css: '[data-ng-if="vm.vpd.profile.title"] span.ng-binding' }
  DESCRIPTION = { css: '[words="80"] span[ng-show="!open"]' }
  SKILLS = { css: '[data-ng-repeat*="skill in items"]' }

  def initialize(driver)
    super
    verify_page
  end

  def get_freelancer_data
    wait 5
    skills_arr = []

    wait_for { displayed? FREELANCER_DATA }
    name = text_of NAME
    title = text_of TITLE
    overview = text_of DESCRIPTION
    skills_ele = find_all SKILLS

    skills_ele.each { |skill|
      skills = skill.text
      skills_arr.push(skills)
    }

    @freelancer_data = {}
    @freelancer_data['name'] = name
    @freelancer_data['title'] = title
    @freelancer_data['overview'] = overview
    @freelancer_data['skills'] = skills_arr
  end

  def is_freelancer_data_equal?
    name = text_of NAME
    hash = $info_arr.detect { |freelancer| freelancer["name"] == name }

    if @freelancer_data['title'].include?(hash['title']) &&
        (@freelancer_data['skills'] & hash['skills']).any? &&
        @freelancer_data['overview'].include?(hash['overview'])
    puts "Test Passed: Data is present on the freelancer's page"
    else
      puts "Test Failed: Data isn't present on the freelancer's page"
    end
  end

  private

  def verify_page
    page_loaded?
    wait_for { displayed? FREELANCER_DATA }
  end
end