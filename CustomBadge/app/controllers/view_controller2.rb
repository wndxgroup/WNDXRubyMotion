class ViewController2 < UIViewController

  DIAMETER = 30

  def viewDidLoad
    super

    $i = image_view = UIImageView.new

    image_view.translatesAutoresizingMaskIntoConstraints = false
    image_view.image = UIImage.imageNamed("github_color")

    view.addSubview(image_view)
    image_view.addBadge

    NSLayoutConstraint.activateConstraints([
      image_view.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
      image_view.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor),
    ])

  end
end