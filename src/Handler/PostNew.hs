{-# LANGUAGE NoImplicitPrelude #-}  --追加
{-# LANGUAGE OverloadedStrings #-}  --追加
{-# LANGUAGE TemplateHaskell #-}  --追加
{-# LANGUAGE MultiParamTypeClasses #-}  --追加
{-# LANGUAGE TypeFamilies #-}  --追加

module Handler.PostNew where

import Import
import Yesod.Form.Bootstrap3
--import Text.Markdown (Markdown)
import Yesod.Text.Markdown

--data BlogPost = BlogPost
--    { title :: Text
--    , article :: Markdown
--    }

blogPostForm :: AForm Handler BlogPost
blogPostForm = BlogPost
    <$> areq textField (bfs ("Title" :: Text)) Nothing
    <*> areq markdownField (bfs ("Article" :: Text)) Nothing



getPostNewR :: Handler Html
--getPostNewR = error "Not yet implemented: getPostNewR"

getPostNewR = do
    (widget, enctype) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm blogPostForm
    defaultLayout $ do
        $(widgetFile "posts/new")

postPostNewR :: Handler Html
postPostNewR = do
    ((res, widget), enctype) <- runFormPost $ renderBootstrap3 BootstrapBasicForm blogPostForm
    case res of
        FormSuccess blogPost -> do
	    blogPostId <- runDB $ insert blogPost
            redirect $ PostDetailsR blogPostId
        _ -> defaultLayout $(widgetFile "posts/new")
