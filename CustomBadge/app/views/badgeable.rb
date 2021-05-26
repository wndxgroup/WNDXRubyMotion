module Badgeable

  DIAMETER = 30
  
  def addBadge
    translatesAutoresizingMaskIntoConstraints = false

    badge = UIButton.new

    badge.translatesAutoresizingMaskIntoConstraints = false
    badge.contentEdgeInsets = UIEdgeInsetsMake(0,4,0,4)
    badge.layer.cornerRadius = DIAMETER / 2
    badge.setTitleColor(UIColor.whiteColor, forState: UIControlStateNormal)
    badge.backgroundColor = UIColor.systemBlueColor
    badge.setTitle("4", forState: UIControlStateNormal)

    addSubview(badge)

    NSLayoutConstraint.activateConstraints([
      badge.heightAnchor.constraintEqualToConstant(Badgeable::DIAMETER),
      badge.widthAnchor.constraintGreaterThanOrEqualToConstant(Badgeable::DIAMETER),
      badge.leadingAnchor.constraintEqualToAnchor(trailingAnchor, constant: -20),
      badge.bottomAnchor.constraintEqualToAnchor(topAnchor, constant: 14),
    ])
  end

end

class UIView
  include Badgeable
end