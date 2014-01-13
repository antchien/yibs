# Yibs - Social betting with friends

This is fully-functional social networking website that helps facilitate bets you make with your friends.  The entire site is built for a single-page user experience, using AJAX calls to a Rails back-end.

How To: Go to www.yibs.co and hit the "Try It Out" button to log in to a sample account. Enjoy!

Technical Synopsis: Build on Ruby on Rails, uses a Javascript/JQuery/AJAX front-end. Features-wise, it encompasses the major Social Media/Facebook-esque features (2-way friending, comments, etc), but also adds the ability to create and manage bets you make with any number of friends.

Features: 
	-2-way friending
	-Multi-way Bet proposals and acceptance/declination logic
	-Custom-built auto-complete search and dropdown feature to allow easily add friends to bets (ala Gmail) and for general user search (PgSearch gem used)
	-3rd-party API integration (Facebook Sign-up/Login, broadcasting onto other 3rd party platforms[coming soon])
	-Community feeds that shows bets of friends, with proper permissioning (private vs. public)
	-Notifications to prompt user of new activity he/she hasn't acknowledged before
	-Infinite paginated scrolling (Kaminari gem used)
	-Uploading of documents (Paperclip gem used)
	-User comments