module IssuesHelper
  def is_author(issue)
    issue.user == current_user
  end
end
