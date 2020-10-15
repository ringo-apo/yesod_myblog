{-# LANGUAGE NoImplicitPrelude #-}  --追加
{-# LANGUAGE OverloadedStrings #-}  --追加
{-# LANGUAGE TemplateHaskell #-}  --追加
{-# LANGUAGE MultiParamTypeClasses #-}  --追加
{-# LANGUAGE TypeFamilies #-}  --追加

module Handler.PostDetails where

import Import

getPostDetailsR :: BlogPostId -> Handler Html
--getPostDetailsR blogPostId = error "Not yet implemented: getPostDetailsR"
getPostDetailsR blogPostId = do
    blogPost <- runDB $ get404 blogPostId
    defaultLayout $ do
        $(widgetFile "postDetails/post")

