class IssueMailer < ApplicationMailer
  default from: 'no-reply-issue@ims.com'

  def issue_resolved_email(user, issue)
    @issue = issue
    mail(
      to: user.email,
      subject: "Issue##{@issue.id} is resolved"
    )
  end
end
