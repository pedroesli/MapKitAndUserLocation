//
//  DroppedPinViewController.swift
//  MapKitAndUserLocation
//
//  Created by Pedro Ésli Vieira do Nascimento on 23/11/21.
//

import UIKit

class DroppedPinViewController: UIViewController {

    var titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 27)
        titleLabel.attributedText = NSAttributedString(string: "Dropped Pin", attributes: [NSAttributedString.Key.kern: 0.54])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    var closeButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
        button.setImage(UIImage(systemName: "xmark", withConfiguration: imageConfig), for: .normal)
        button.setBackgroundImage(UIImage(named: "CloseButtonBackground"), for: .normal)
        button.tintColor = .secondaryLabel
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        //scrollView.backgroundColor = .red
        return scrollView
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        label.text = "450 m de distância"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.attributedText = NSAttributedString(string: "Details", attributes: [NSAttributedString.Key.kern: -0.38])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var detailContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundSecondary
        view.layer.cornerRadius = 9
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var addressTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.attributedText = NSAttributedString(string: "Address", attributes: [NSAttributedString.Key.kern: -0.07])
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        let attributes = [
            NSAttributedString.Key.kern: -0.51,
            NSAttributedString.Key.paragraphStyle: NSMutableParagraphStyle(lineSpacing: 2)
        ] as [NSAttributedString.Key : Any]
        label.attributedText = NSAttributedString(string: "Chácara 325\nTaguatinga\nBrasília - DF\n72444\nBrasil", attributes: attributes)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var coordinatesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.attributedText = NSAttributedString(string: "Coordinates", attributes: [NSAttributedString.Key.kern: -0.07])
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var coordinatesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.attributedText = NSAttributedString(string: "15,40054° S, 48,04333° O", attributes: [NSAttributedString.Key.kern: -0.51])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var delegate: DroppedPinDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(detailContentView)
        detailContentView.addSubview(addressTitleLabel)
        detailContentView.addSubview(addressLabel)
        detailContentView.addSubview(lineView)
        detailContentView.addSubview(coordinatesTitleLabel)
        detailContentView.addSubview(coordinatesLabel)
        
        NSLayoutConstraint.activate([
            //Title Label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            //Close Button
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            //Scroll View +
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //Content View ++
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            //Distance Label
            distanceLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            distanceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            distanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            //Detail Label
            detailLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 15),
            detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            //Detail Content View +++
            detailContentView.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 10),
            detailContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detailContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            detailContentView.bottomAnchor.constraint(equalTo: coordinatesLabel.bottomAnchor, constant: 15),
            //Address Title Label
            addressTitleLabel.topAnchor.constraint(equalTo: detailContentView.topAnchor, constant: 15),
            addressTitleLabel.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: 16),
            addressTitleLabel.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: -16),
            //Address Label
            addressLabel.topAnchor.constraint(equalTo: addressTitleLabel.bottomAnchor, constant: 2),
            addressLabel.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: 16),
            addressLabel.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: -16),
            //Line View
            lineView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 15),
            lineView.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: 16),
            lineView.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.5),
            //Coordinates Title Label
            coordinatesTitleLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 15),
            coordinatesTitleLabel.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: 16),
            coordinatesTitleLabel.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: -16),
            //Coordinates Label
            coordinatesLabel.topAnchor.constraint(equalTo: coordinatesTitleLabel.bottomAnchor, constant: 2),
            coordinatesLabel.leadingAnchor.constraint(equalTo: detailContentView.leadingAnchor, constant: 16),
            coordinatesLabel.trailingAnchor.constraint(equalTo: detailContentView.trailingAnchor, constant: -16)
        ])
        
        //scrollView.contentSize = CGSize(width: view.frame.width, height: 1000)
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
    }
    
    @objc func closeButtonPressed(){
        delegate?.droppedPinCloseButtonPressed()
    }
}
