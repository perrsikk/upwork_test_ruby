require_relative '../../lib/env'
require_relative '../../lib/base'

class IndexPage < Base

  SEARCH_BOX = { css: 'input[data-qa="s_input"]' }
  BANNER = { class: 'ee-hero-section' }

  def initialize(driver)
    super
    visit
    verify_page
  end

  def search_for(search_term)
    type SEARCH_BOX, search_term
    submit SEARCH_BOX
  end

  # def search_result_present?(search_result)
  #   wait_for { displayed?(TOP_SEARCH_RESULT) }
  #   text_of(TOP_SEARCH_RESULT).include? search_result
  # end

  private

  def verify_page
    wait_for { displayed?(BANNER) }
  end
end