{-# LANGUAGE OverloadedStrings #-}
--------------------------------------------------------------------------------
import           Hakyll
import           Control.Monad    (forM_)
--------------------------------------------------------------------------------
config :: Configuration
config = defaultConfiguration { destinationDirectory = "docs" }

main :: IO ()
main = hakyllWith config $ do
    -- Static files
    forM_ ["favicon.ico"
          , "CNAME"
          , "robots.txt"
          , "fonts/*"
          , "cv.pdf"] $ \f -> match f $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "index.md" $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "templates/*" $ compile templateCompiler
