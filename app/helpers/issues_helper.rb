module IssuesHelper
  def is_author_of(issue)
    issue.user == current_user
  end

  def is_author
    redirect_to issues_path unless @issue.user == current_user
  end

  def notify_user
    @user = User.find(@issue.user_id)
    IssueMailer.issue_resolved_email(@user, @issue).deliver_now
  end
end
