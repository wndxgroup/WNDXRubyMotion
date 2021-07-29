class ViewController3 < UIViewController

  DIAMETER = 30

  def viewDidLoad
    super

    $i = image_view = UIImageView.new

    image_view.translatesAutoresizingMaskIntoConstraints = false
    image_view.image = UIImage.imageNamed("github_color")

    view.addSubview(image_view)
    image_view.addCGBadge("4")

    NSLayoutConstraint.activateConstraints([
       image_view.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
       image_view.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor),
   ])

  end
end