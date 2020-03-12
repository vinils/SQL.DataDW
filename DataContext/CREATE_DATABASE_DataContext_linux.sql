USE [master]
GO

/****** Object:  Database [DataContext]    Script Date: 8/11/2019 3:13:06 PM ******/
CREATE DATABASE [DataContext]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DataContext', FILENAME = N'/var/opt/mssql/data/DataContext.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DataContext_log', FILENAME = N'/var/opt/mssql/data/DataContext_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [DataContext] SET COMPATIBILITY_LEVEL = 140
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DataContext].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [DataContext] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [DataContext] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [DataContext] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [DataContext] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [DataContext] SET ARITHABORT OFF 
GO

ALTER DATABASE [DataContext] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [DataContext] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [DataContext] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [DataContext] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [DataContext] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [DataContext] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [DataContext] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [DataContext] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [DataContext] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [DataContext] SET  ENABLE_BROKER 
GO

ALTER DATABASE [DataContext] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [DataContext] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [DataContext] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [DataContext] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [DataContext] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [DataContext] SET READ_COMMITTED_SNAPSHOT ON 
GO

ALTER DATABASE [DataContext] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [DataContext] SET RECOVERY FULL 
GO

ALTER DATABASE [DataContext] SET  MULTI_USER 
GO

ALTER DATABASE [DataContext] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [DataContext] SET DB_CHAINING OFF 
GO

ALTER DATABASE [DataContext] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [DataContext] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [DataContext] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [DataContext] SET QUERY_STORE = OFF
GO

ALTER DATABASE [DataContext] SET  READ_WRITE 
GO


