class IssueMailer < ApplicationMailer
  default from: 'no-reply-issue@ims.com'

  def issue_resolved_email(user, issue)
    @issue = issue
    mail(
      to: user.email,
      subject: "Your issue with id #{@issue.id} is resolved"
    )
  end
end
