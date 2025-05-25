class InvitationMailer < ApplicationMailer
  def send_invitation(invitation)
    @invitation = invitation
    mail(to: @invitation.email, subject: 'You are invited to join a team!')
  end
end
