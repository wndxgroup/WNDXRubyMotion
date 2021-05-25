class ViewController1 < UIViewController

  DIAMETER = 30

  def viewDidLoad()
    super

    $l = label = UILabel.new
    label.translatesAutoresizingMaskIntoConstraints = false
    label.layer.cornerRadius = DIAMETER / 2
    label.backgroundColor = UIColor.systemRedColor
    label.textAlignment = NSTextAlignmentCenter
    label.textColor = UIColor.whiteColor
    label.clipsToBounds = true
    label.text = "99" # Good for 2 digits

    $b = button = UIButton.new
    button.translatesAutoresizingMaskIntoConstraints = false
    button.contentEdgeInsets = UIEdgeInsetsMake(0,4,0,4)
    button.layer.cornerRadius = DIAMETER / 2
    button.setTitleColor(UIColor.whiteColor, forState: UIControlStateNormal)
    button.backgroundColor = UIColor.systemBlueColor
    button.setTitle("4444", forState: UIControlStateNormal)

    view.addSubview(label)
    view.addSubview(button)

    NSLayoutConstraint.activateConstraints([
      label.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
      label.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor),
      label.heightAnchor.constraintEqualToConstant(DIAMETER),
      label.widthAnchor.constraintGreaterThanOrEqualToConstant(DIAMETER),
      button.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
      button.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: 50),
      button.heightAnchor.constraintEqualToConstant(DIAMETER),
      button.widthAnchor.constraintGreaterThanOrEqualToConstant(DIAMETER),
    ])


  end
end