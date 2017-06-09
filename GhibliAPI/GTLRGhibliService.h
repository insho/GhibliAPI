// NOTE: This file was generated by the ServiceGenerator.

// ----------------------------------------------------------------------------
// API:
//   Ghibli API (calendar/v3)
// Description:
//   Manipulates events and other calendar data.
// Documentation:
//   https://developers.google.com/google-apps/calendar/firstapp

#if GTLR_BUILT_AS_FRAMEWORK
#import "GTLR/GTLRService.h"
#else
#import "GTLRService.h"
#endif

#if GTLR_RUNTIME_VERSION != 3000
#error This file was generated by a different version of ServiceGenerator which is incompatible with this GTLR library source.
#endif

NS_ASSUME_NONNULL_BEGIN

// ----------------------------------------------------------------------------
// Authorization scopes

/**
 *  Authorization scope: Manage your calendars
 *
 *  Value "https://www.googleapis.com/auth/calendar"
 */
GTLR_EXTERN NSString * const kGTLRAuthScopeCalendar;
/**
 *  Authorization scope: View your calendars
 *
 *  Value "https://www.googleapis.com/auth/calendar.readonly"
 */
GTLR_EXTERN NSString * const kGTLRAuthScopeCalendarReadonly;

// ----------------------------------------------------------------------------
//   GTLRCalendarService
//

/**
 *  Service for executing Calendar API queries.
 *
 *  Manipulates events and other calendar data.
 */
@interface GTLRGhibliService : GTLRService

// No new methods

// Clients should create a standard query with any of the class methods in
// GTLRCalendarQuery.h. The query can the be sent with GTLRService's execute
// methods,
//
//   - (GTLRServiceTicket *)executeQuery:(GTLRQuery *)query
//                     completionHandler:(void (^)(GTLRServiceTicket *ticket,
//                                                 id object, NSError *error))handler;
// or
//   - (GTLRServiceTicket *)executeQuery:(GTLRQuery *)query
//                              delegate:(id)delegate
//                     didFinishSelector:(SEL)finishedSelector;
//
// where finishedSelector has a signature of:
//
//   - (void)serviceTicket:(GTLRServiceTicket *)ticket
//      finishedWithObject:(id)object
//                   error:(NSError *)error;
//
// The object passed to the completion handler or delegate method
// is a subclass of GTLRObject, determined by the query method executed.

@end

NS_ASSUME_NONNULL_END
