#input: job app
#output: [time to job, {responses}]

#role: [time, *tasks]

class Resume
  def initialize(languages = [], experience = 0, roles = {})
    @languages = languages
    @experience = experience
    @roles = roles
  end
end

class Project
  def initialize(languages = [], description = '', url = '')
    @languages = languages
    @description = description
    @url = url
  end
end

def get_job(cover_letter = '', resume = Resume.new, projects = Project.new)
  cover_ltr_score = ''

  p cover_letter + "\n"
  until cover_ltr_score == /[0-4]/
    p 'Rate for fit from 0 to 4: '
    cover_ltr_score = gets.chomp
  end

  #...
end

# a brief mock-up/skeleton, just as proof of concept to code this out
# next, would flesh out algorithm via discussion
