require 'redmine'

require 'issues_helper_patch'
require 'application_helper_patch'

Redmine::Plugin.register :redmine_greenmine_role do
  name 'Redmine Greenmine role plugin'
  author 'Greenmine-PMI'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/greenmine-pmi/redmine_greenmine_role'
  author_url 'http://greenmine-pmi.blogspot.com/'
end

require 'dispatcher'
Dispatcher.to_prepare :redmine_greenmine do

  require_dependency 'issue'
  Issue.safe_attributes "gm_responsible_id"
  Issue.send(:include, RedmineGreenmine::Patches::IssuePatch)
end


require 'redmine_greenmine_role/hooks/view_issues_show_details_bottom_hook'
require 'redmine_greenmine_role/hooks/view_issues_form_details_bottom_hook'

