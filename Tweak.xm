%hook UIAlertControllerVisualStyleActionSheet

- (float)backgroundCornerRadius {
	return 0.0;
}

- (UIEdgeInsets)contentInsets {
	return UIEdgeInsetsZero;
}

- (BOOL)hideActionSeparators {
	return YES;
}

- (BOOL)hideCancelAction:(id)action inAlertController:(UIAlertController *)controller {
	return YES;
}

%end
