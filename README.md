# DeskScripts
Various Ruby scripts implementing the Desk.com API

KnowledgeBase_GetTopics.rb

Retrieves all KnowledgeBase topics and stores the response in a file. Useful for seeing the topic ids so you can update topic attributes.

KnowledgeBase_CreateTopics.rb

Iterates through csv file to create topic with corresponding description in Desk KnowledgeBase.

KnowledgeBase_UpdateTopics.rb

Adds topic brand_id to each topic
Prerequisite:
Topic id (use KnowledgeBase_GetTopics.rb)
