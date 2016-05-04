class Resource < ActiveRecord::Base
  belongs_to :phase_day, required: false

  validates :kind, presence: true
  
  enum kind: ['DBC Talk', 'Article/Doc', 'Repo', 'Mindmap', 'Spreadsheet',
    'Gist', 'Video', 'Web App']

end
