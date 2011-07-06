require 'redmine'

require 'issues_helper_patch'
require 'application_helper_patch'
#require 'redmine_export_pdf_patch' # overwrite base class


Redmine::Plugin.register :redmine_greenmine_role do
  name 'Redmine Greenmine role plugin'
  author 'Greenmine-PMI'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'https://github.com/greenmine-pmi/redmine_greenmine_role'
  author_url 'http://greenmine-pmi.blogspot.com/'

 project_module :issue_tracking do
    permission(:issue_move_up_down, {})
    permission(:issue_edit_start_date, {})
    permission(:issue_edit_due_date, {})
    permission(:issue_edit_priority, {})
    permission(:issue_edit_assigned_to, {})
    permission(:issue_edit_done_ratio, {})
    permission(:issue_edit_status, {})
  end


end

require 'dispatcher'
Dispatcher.to_prepare :redmine_greenmine_role do

  require_dependency 'issue'
  Issue.safe_attributes "gm_responsible_id"
  Issue.send(:include, RedmineGreenmineRole::Patches::IssuePatch)
end


require 'redmine_greenmine_role/hooks/view_issues_show_details_bottom_hook'
require 'redmine_greenmine_role/hooks/view_issues_form_details_bottom_hook'

