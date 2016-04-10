class SubmissionPolicy < ApplicationPolicy
    def is_owner?
        record.owner?(user)
    end
    def update?
        is_owner? && record.may_sm_update?
    end
    def submit?
        is_owner? && record.may_sm_submit?
    end
    def revise?
        is_owner? && record.may_sm_revise?
    end
    def destroy?
        is_owner? && record.may_sm_destroy?
    end
end
